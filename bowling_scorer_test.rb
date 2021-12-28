require 'test/unit'
require_relative './bowling_scorer.rb'

class BowlingScorerTest < Test::Unit::TestCase
  def setup
    @scorer = BowlingScorer.new
  end

  def assert_error(game, message)
    assert_raise(RuntimeError.new(message)) { @scorer.score(game) }
  end

  def assert_score(game, score)
    assert_equal(score, @scorer.score(game))
  end

  def test_raises_error_when_game_is_not_string
    assert_error(0, 'Invalid type')
    assert_error(:a, 'Invalid type')
    @scorer.score('X|X|X|X|X|X|X|X|X|X||XX')
  end

  def test_raises_error_when_game_is_invalid
    assert_error('', 'Invalid game')
    assert_error('--|--|--|--|--|--|--|--|--|--|', 'Invalid game')
    assert_error('--|--|--|--|--|--|--|--|--|--|-|', 'Invalid game')
    @scorer.score('--|--|--|--|--|--|--|--|--|--||')
  end

  def test_raises_error_when_frame_size_is_invalid
    assert_error('|--|--|--|--|--|--|--|--|--||', 'Invalid frame: ')
    assert_error('--||--|--|--|--|--|--|--|--||', 'Invalid frame: ')
    assert_error('--|--|---|--|--|--|--|--|--|--||', 'Invalid frame: ---')
  end

  def test_raises_error_when_frame_hits_are_invalid
    assert_error('-a|--|--|--|--|--|--|--|--|--||', 'Invalid hit: a')
    assert_error('--|-b|--|--|--|--|--|--|--|--||', 'Invalid hit: b')
    assert_error('--|--|c-|--|--|--|--|--|--|--||', 'Invalid hit: c')
  end

  def test_calculates_sum_when_all_frames_are_the_same
    assert_score('--|--|--|--|--|--|--|--|--|--||', 0)
    assert_score('-1|-1|-1|-1|-1|-1|-1|-1|-1|-1||', 10)
    assert_score('-2|-2|-2|-2|-2|-2|-2|-2|-2|-2||', 20)
    assert_score('3-|3-|3-|3-|3-|3-|3-|3-|3-|3-||', 30)
  end
end
