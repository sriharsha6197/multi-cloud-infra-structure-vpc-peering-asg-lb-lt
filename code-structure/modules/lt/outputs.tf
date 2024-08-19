output "iam_instance_profile" {
  value = resource.aws_iam_instance_profile.test_profile.name
}