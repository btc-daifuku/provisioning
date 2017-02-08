data "aws_route53_zone" "selected" {
  name = "btc-daifuku.tk."
}

#####################################
# OpenAM Alias Record
#####################################
resource "aws_route53_record" "openam" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name = "auth.btc-daifuku.tk"
  type = "A"

  alias {
    name = "${aws_alb.openam.dns_name}"
    zone_id = "${aws_alb.openam.zone_id}"
    evaluate_target_health = false
  }

  depends_on = [
    "aws_alb.openam"
  ]
}

#####################################
# OpenDJ Alias Record
#####################################
resource "aws_route53_record" "opendj" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name = "ldap.btc-daifuku.tk"
  type = "A"

  alias {
    name = "${aws_alb.opendj.dns_name}"
    zone_id = "${aws_alb.opendj.zone_id}"
    evaluate_target_health = false
  }

  depends_on = [
    "aws_alb.opendj"
  ]
}
