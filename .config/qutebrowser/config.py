config.load_autoconfig(False)

dark_sites = [
    "https://vnexpress.net",
    "https://github.com",
]

for site in dark_sites:
    config.set("colors.webpage.darkmode.enabled", True, site)
