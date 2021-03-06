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
create or replace function test_case_v6_array_to_text1() returns void as $$
declare
  ipaddr text;
  v6_array text[];
begin
  -- 2001:0db8:0a0b:12f0:0000:0000:0000:0001
  v6_array = array[ '2', '0', '0', '1' ];
  v6_array = array_cat( v6_array, ARRAY[ '0', 'd', 'b', '8' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', 'a', '0', 'b' ] );
  v6_array = array_cat( v6_array, ARRAY[ '1', '2', 'f', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '1' ] );

  -- zero pad
  SELECT v6_array_to_text( v6_array, true ) into ipaddr;
  perform test_assertNotNull('ipaddr not null', ipaddr);
  perform test_assertTrue('ipaddr zero padded', ipaddr = '2001:0db8:0a0b:12f0:0000:0000:0000:0001' );

  -- no zero pad
  SELECT v6_array_to_text( v6_array, false ) into ipaddr;
  perform test_assertNotNull('ipaddr not null', ipaddr);
  raise notice 'not zero padded ipaddr = %', ipaddr;
  perform test_assertTrue('ipaddr zero padded', ipaddr = '2001:db8:a0b:12f0::1' );
end;
$$ language plpgsql;

select * from test_case_v6_array_to_text1();

create or replace function test_case_v6_array_to_text2() returns void as $$
declare
  ipaddr text;
  v6_array text[];
begin
  -- 2001:0000:0000:12f0:0000:0000:0000:0001
  v6_array = array[ '2', '0', '0', '1' ];
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '1', '2', 'f', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '1' ] );

  -- no zero pad
  SELECT v6_array_to_text( v6_array, false ) into ipaddr;
  perform test_assertNotNull('ipaddr not null', ipaddr);
  raise notice 'not zero padded ipaddr = %', ipaddr;
  perform test_assertTrue('ipaddr zero padded', ipaddr = '2001::12f0:0:0:0:1' );
end;
$$ language plpgsql;

select * from test_case_v6_array_to_text2();

create or replace function test_case_v6_array_to_text3() returns void as $$
declare
  ipaddr text;
  v6_array text[];
begin
  -- 0001:0000:0000:0000:0000:0000:0000:0001
  v6_array = array[ '0', '0', '0', '0' ];
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '0' ] );
  v6_array = array_cat( v6_array, ARRAY[ '0', '0', '0', '1' ] );

  -- no zero pad
  SELECT v6_array_to_text( v6_array, false ) into ipaddr;
  perform test_assertNotNull('ipaddr not null', ipaddr);
  raise notice 'not zero padded ipaddr = %', ipaddr;
  perform test_assertTrue('ipaddr zero padded', ipaddr = '::1' );
end;
$$ language plpgsql;

select * from test_case_v6_array_to_text3();
