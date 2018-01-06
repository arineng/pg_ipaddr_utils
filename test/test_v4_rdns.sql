/*
Copyright (C) 2017 American Registry for Internet Numbers (ARIN)

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
create or replace function test_case_v4_rdns() returns void as $$
declare
  dns text;
begin

  -- /16
  SELECT v4_rdns( inet '192.168.0.1/16' ) into dns;
  perform test_assertNotNull('dns not null', dns);
  perform test_assertTrue('dns /16', dns = '168.192.in-addr.arpa' );

  -- /24
  SELECT v4_rdns( inet '192.168.0.1/24' ) into dns;
  perform test_assertNotNull('dns not null', dns);
  perform test_assertTrue('dns /24', dns = '0.168.192.in-addr.arpa' );

  -- /8
  SELECT v4_rdns( inet '192.168.0.1/8' ) into dns;
  perform test_assertNotNull('dns not null', dns);
  perform test_assertTrue('dns /8', dns = '192.in-addr.arpa' );
end;
$$ language plpgsql;

select * from test_case_v4_rdns();
