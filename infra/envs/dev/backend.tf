terraform {
  backend "s3" {
    bucket         = "surya-project-one-terraform-state-2244"  # S3 bucket you created
    key            = "dev/terraform.tfstate"                   # Path inside bucket
    region         = "us-east-1"                                # Same as bucket region
    dynamodb_table = "terraform-locks"                          # DynamoDB table for state locking
    encrypt        = true                                       # Encrypt the state file
  }
}

