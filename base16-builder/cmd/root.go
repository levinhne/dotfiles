package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "base16go",
	Short: "Base16Go is a tool for generating color schemes",
	Long:  `Base16Go is a tool for generating color schemes using templates and YAML configurations.`,
	Run: func(cmd *cobra.Command, args []string) {
		// Default action for root command
		fmt.Println("Please use a subcommand")
	},
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
