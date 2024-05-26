package cmd

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"text/template"

	"github.com/charmbracelet/lipgloss"
	"github.com/levinhne/base16-builder/colorschemes"
	"github.com/pelletier/go-toml"
	"github.com/spf13/cobra"
	"gopkg.in/yaml.v2"
)

type Config struct {
	Items []struct {
		Template string `toml:"template"`
		File     string `toml:"file"`
	} `toml:"items"`
}

type ColorScheme struct {
	System  string
	Name    string
	Author  string
	Variant string
	Palette map[string]string
}

func format(scheme ColorScheme) {
	for _, color := range scheme.Palette {
		fmt.Print(lipgloss.NewStyle().
			Background(lipgloss.Color("#" + color)).
			Align(lipgloss.Center).
			Width(3),
		)
	}
}

func expandPath(path string) string {
	if path[:2] == "~/" {
		home, err := os.UserHomeDir()
		if err != nil {
			log.Fatalf("Error getting home directory: %v", err)
		}
		return filepath.Join(home, path[2:])
	}
	return path
}

var schemeCmd = &cobra.Command{
	Use:   "scheme [name]",
	Short: "Generate color scheme files",
	Long:  `Generate color scheme files based on the given scheme name.`,
	Args:  cobra.MinimumNArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		schemeName := args[0]

		// Đường dẫn đến tệp YAML trong thư mục .config/colorschemes
		yamlDir := filepath.Join(os.Getenv("HOME"), ".config", "colorschemes")
		yamlFilePath := filepath.Join(yamlDir, schemeName+".yaml")

		var yamlData []byte
		var err error

		// Kiểm tra xem tệp có tồn tại trong thư mục .config/colorschemes không
		if _, err := os.Stat(yamlFilePath); err == nil {
			yamlData, err = os.ReadFile(yamlFilePath)
			if err != nil {
				log.Fatalf("Error reading YAML file %s: %v", yamlFilePath, err)
			}
		} else {
			// Nếu tệp không tồn tại, đọc từ embedded file system
			embeddedFilePath := fmt.Sprintf("%s.yaml", schemeName)
			yamlData, err = colorschemes.EmbeddedSchemes.ReadFile(embeddedFilePath)
			if err != nil {
				log.Fatalf("Error reading embedded YAML file %s: %v", embeddedFilePath, err)
			}
		}

		// Unmarshal YAML vào struct
		var scheme ColorScheme
		if err := yaml.Unmarshal(yamlData, &scheme); err != nil {
			log.Fatalf("Error unmarshaling YAML: %v", err)
		}

		format(scheme)
		fmt.Println()

		// Đọc cấu hình từ tệp TOML
		config, err := readConfig("config.toml")
		if err != nil {
			log.Fatalf("Error reading configuration: %v", err)
		}

		// Lặp qua từng mục trong cấu hình
		for _, item := range config.Items {
			// Đọc tệp mẫu
			templateContent, err := os.ReadFile(item.Template)
			if err != nil {
				log.Fatalf("Error reading template file %s: %v", item.Template, err)
			}

			// Phân tích mẫu
			tmpl, err := template.New(filepath.Base(item.Template)).Parse(string(templateContent))
			if err != nil {
				log.Fatalf("Error parsing template %s: %v", item.Template, err)
			}

			// Tạo tệp đầu ra
			outputFile, err := os.Create(expandPath(item.File))
			if err != nil {
				log.Fatalf("Error creating output file %s: %v", item.File, err)
			}
			defer outputFile.Close()

			// Thực hiện mẫu với dữ liệu và ghi vào tệp đầu ra
			fmt.Printf("Output for template %s written to file %s\n", item.Template, item.File)
			err = tmpl.Execute(outputFile, scheme)
			if err != nil {
				log.Fatalf("Error executing template %s: %v", item.Template, err)
			}
		}
	},
}

func readConfig(filePath string) (*Config, error) {
	config := &Config{}

	// Đọc tệp TOML
	tomlFile, err := os.ReadFile(filePath)
	if err != nil {
		return nil, err
	}

	// Phân tích dữ liệu TOML
	if err := toml.Unmarshal(tomlFile, config); err != nil {
		return nil, err
	}

	return config, nil
}

func init() {
	rootCmd.AddCommand(schemeCmd)
}
