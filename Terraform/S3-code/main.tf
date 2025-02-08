resource "aws_s3_bucket" "buckets" {
  count  = 5  # Creates 5 identical resources
  bucket = "prathameshs3buckethh-${count.index + 1}"  # Unique name for each bucket

  # Optional additional configuration
  tags = {
    Environment = "Test"
  }
}