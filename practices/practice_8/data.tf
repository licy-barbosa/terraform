# con data leemos datos ya existentes en AWS v.30
data "aws_key_pair" "key_practice" {
  key_name = "mykeypractice"
  provider = aws.ohio
}
