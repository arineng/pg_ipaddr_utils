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
create or replace function test_case_v6_text_to_array1() returns void as $$
declare
  v6_array text[];
  actual text[];
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
  SELECT v6_text_to_array( '2001:0db8:0a0b:12f0:0000:0000:0000:0001' ) into actual;
  perform test_assertNotNull('actual not null', actual);
  raise notice 'not zero padded actual = %', actual;
  perform test_assertTrue('actual zero padded', actual = v6_array );

  -- no zero pad
  SELECT v6_text_to_array( '2001:db8:a0b:12f0::1' ) into actual;
  perform test_assertNotNull('actual not null', actual);
  raise notice 'not zero padded actual = %', actual;
  perform test_assertTrue('actual no zero padded', actual = v6_array );
end;
$$ language plpgsql;

select * from test_case_v6_text_to_array1();

create or replace function test_case_v6_text_to_array2() returns void as $$
declare
  v6_array text[];
  actual text[];
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
  SELECT v6_text_to_array( '2001::12f0:0:0:0:1' ) into actual;
  perform test_assertNotNull('actual not null', actual);
  raise notice 'not zero padded actual = %', actual;
  perform test_assertTrue('actual no zero padded', actual = v6_array );
end;
$$ language plpgsql;

select * from test_case_v6_text_to_array2();

create or replace function test_case_v6_text_to_array3() returns void as $$
declare
  v6_array text[];
  actual text[];
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
  SELECT v6_text_to_array( '::1' ) into actual;
  perform test_assertNotNull('actual not null', actual);
  raise notice 'not zero padded actual = %', actual;
  perform test_assertTrue('actual no zero padded', actual = v6_array );
end;
$$ language plpgsql;

select * from test_case_v6_text_to_array3();
