terraform {
 backend "s3" {
   encrypt = true
   bucket = "${var.bucket}"
   region = "${var.region}"
   key = "assignment/suresh.state"
 }
}
