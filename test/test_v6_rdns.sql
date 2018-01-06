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
create or replace function test_case_v6_rdns() returns void as $$
declare
  dns text;
begin

  -- /64
  SELECT v6_rdns( inet '2001:db8:a0b:12f0::1/64' ) into dns;
  raise notice 'dns /64 = %', dns;
  perform test_assertNotNull('dns not null', dns);
  perform test_assertTrue('dns /64', dns = '0.f.2.1.b.0.a.0.8.b.d.0.1.0.0.2.ip6.arpa' );

  -- /52
  SELECT v6_rdns( inet '2001:db8:a0b:12f0::1/52' ) into dns;
  raise notice 'dns /52 = %', dns;
  perform test_assertNotNull('dns not null', dns);
  perform test_assertTrue('dns /52', dns = '1.b.0.a.0.8.b.d.0.1.0.0.2.ip6.arpa' );

  -- /48
  SELECT v6_rdns( inet '2001:db8:a0b:12f0::1/48' ) into dns;
  raise notice 'dns /48 = %', dns;
  perform test_assertNotNull('dns not null', dns);
  perform test_assertTrue('dns /48', dns = 'b.0.a.0.8.b.d.0.1.0.0.2.ip6.arpa' );

  -- /12
  SELECT v6_rdns( inet '2001:db8:a0b:12f0::1/12' ) into dns;
  raise notice 'dns /12 = %', dns;
  perform test_assertNotNull('dns not null', dns);
  perform test_assertTrue('dns /12', dns = '0.0.2.ip6.arpa' );

end;
$$ language plpgsql;

select * from test_case_v6_rdns();
