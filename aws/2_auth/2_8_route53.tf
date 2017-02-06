data "aws_route53_zone" "selected" {
  name = "btc-daifuku.tk."
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name = "auth.btc-daifuku.tk"
  type = "A"

  alias {
    #name = "${aws_elb.auth.dns_name}"
    #zone_id = "${aws_elb.auth.zone_id}"
    name = "${aws_alb.auth.dns_name}"
    zone_id = "${aws_alb.auth.zone_id}"
    evaluate_target_health = false
  }
}
