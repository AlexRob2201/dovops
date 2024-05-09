terraform {
  backend "s3" {
    AWS_REGION = var.region
    bucket         = "danit-devops-tf-state"
    # Example
    key            = "eks/terraform.tfstate"
    encrypt        = true
    # Example
    #dynamodb_table = "lock-tf-eks"
    dynamodb_table = "bukhenko-tf-step" 
    # dynamo key LockID
    # Params tekan from -backend-config when terraform init
    #region = 
    #profile = 
  }
}

