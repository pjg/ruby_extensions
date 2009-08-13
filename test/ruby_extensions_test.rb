require 'test/unit'
require File.dirname(__FILE__) + '/test_helper'

class RubyExtensionsTest < ActiveSupport::TestCase

  def test_array_extensions
    assert [].respond_to?(:arithmetic_mean)
    assert_equal [1, 2, 3, 4, 5].arithmetic_mean, 3.0

    assert [].respond_to?(:geometric_mean)
    assert_equal [2, 3, 4.5].geometric_mean, 3.0
  end

  def test_string_extensions
    assert ''.respond_to?(:to_slug)

    # to_slug: Polish accented characters
    assert_equal 'ęóąśłżźćń ĘÓĄŚŁŻŹĆŃ'.to_slug, 'eoaslzzcn-eoaslzzcn'

    # to_slug: Kaszubian accented characters
    assert_equal 'ÃãÉéËëÒòÔôÙù'.to_slug, 'aaeeeeoooouu'

    # to_slug: Iñtërnâtiônàlizætiøn
    assert_equal 'Iñtërnâtiônàlizætiøn'.to_slug, 'internationalizaetion'

    # to_slug: other accented characters
    assert_equal 'āčēģīķļņū'.to_slug, 'acegiklnu'
    assert_equal '中文測試'.to_slug, 'zhong-wen-ce-shi'
    assert_equal 'fööbär'.to_slug, 'foobar'

    # to_slug: hyphens
    assert_equal 'a-b‐c‒d–e—f―g⁃h−i­j'.to_slug, 'a-b-c-d-e-f-g-h-i-j'

    # to_slug: various
    assert_equal '!@#$%^&*()_+[]{}|;\':",./<>?/// aaaa_bbbb \\ ?@#$?`~'.to_slug, 'aaaa-bbbb'
    assert_equal '////// meph1sto r0x ! \\\\\\'.to_slug, 'meph1sto-r0x'
    assert_equal '!@ To$Łódź?żółć!pójdź[]do-mnie'.to_slug, 'to-lodz-zolc-pojdz-do-mnie'
    assert_equal 'zAżÓłĆ_łódź-–--mą_mnĄ–kÔÔ-tęrr'.to_slug, 'zazolc-lodz-ma-mna-koo-terr'
    assert_equal 'Czy to był kaszëbskô horror w Żarach?'.to_slug, 'czy-to-byl-kaszebsko-horror-w-zarach'

    # sanitize_as_filename
    assert_equal 'C:\Temp\ęóąśłżźćń.txt'.sanitize_as_filename, 'eoaslzzcn.txt'
  end

  def test_time_formatters
    time = Time.now
    assert_equal time.strftime('%Y-%m-%d %H:%M'), time.to_s(:detailed)
  end

end
