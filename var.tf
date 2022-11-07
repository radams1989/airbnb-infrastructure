variable "AMI_ID" {
    type = string
    description = "AMI_ID"
    default = "ami-0149b2da6ceec4bb0"
  
}
variable "INSTANCE_TYPE" {
    type = string
    description = "type of ece instance "
    default = "t3.micro"
  
}
variable "bucket_name" {
    type = string
    default = "nibafrde1234677377"
    description = "Bucket Name"
}