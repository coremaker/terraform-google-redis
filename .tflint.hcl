plugin "google" {
    enabled = true
    version = "0.19.0"
    source  = "github.com/terraform-linters/tflint-ruleset-google"
}

# Enforces naming conventions. It accepts only snake_case, mixed_snake_case and none. 
rule "terraform_naming_convention" {
    enabled = true
}

# Disallow variables, data sources, and locals that are declared but never used.
rule "terraform_unused_declarations" {
    enabled = true
}   

# Disallow variable declarations without type - the code would be easier to read.
rule "terraform_typed_variables" {
    enabled = true
}