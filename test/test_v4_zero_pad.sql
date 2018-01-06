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
create or replace function test_case_v4_zero_pad() returns void as $$
declare
  ipaddr text;
begin

  -- string
  SELECT v4_zero_pad( '192.168.0.1' ) into ipaddr;
  perform test_assertNotNull('ipaddr not null', ipaddr);
  perform test_assertTrue('ipaddr 192.168.000.001', ipaddr = '192.168.000.001' );

end;
$$ language plpgsql;

select * from test_case_v4_zero_pad();
