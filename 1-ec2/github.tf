terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.3.2"
    }
  }
}

provider "github" {
  token = ""
}

resource "github_repository" "terraform-repo" {
  name        = "terraform-repo"

  visibility  = "private"

}