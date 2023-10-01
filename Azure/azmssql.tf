resource "azurerm_mssql_server" "mssql" {
  name                         = "sqlservertf32173492847120"
  resource_group_name          = local.resouce_group_name
  location                     = local.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}
resource "azurerm_mssql_database" "testing" {
  name           = "sqlacctest321"
  server_id      = azurerm_mssql_server.mssql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true
  depends_on =[azurerm_mssql_server.mssql]
}