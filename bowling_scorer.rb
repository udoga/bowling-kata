class BowlingScorer
  def score(game)
    raise 'Invalid type' unless game.is_a?(String)
    return score_frames(game.split('|', -1))
  end

  private

  def score_frames(frames)
    raise 'Invalid game' if frames.size() != 12 or not frames[10].empty?
    (0..9).map {|i| score_frame(frames[i], frames[i+1..-1].join)}.sum()
  end

  def score_frame(frame, rest)
    raise 'Invalid frame: ' + frame if frame != 'X' and frame.size != 2
    score = score_hits(frame, frame.size)
    score += score_hits(rest, 2) if frame[-1] == 'X'
    score += score_hits(rest, 1) if frame[-1] == '/'
    return score
  end

  def score_hits(hits, size)
    raise 'Missing hits' if hits.size < size
    score = score_hit(hits[0])
    return score if size == 1
    return 10 if hits[1] == '/'
    return score + score_hit(hits[1])
  end

  def score_hit(hit)
    return 0 if hit == '-'
    return 10 if hit == 'X'
    return hit.to_i if hit.to_i.to_s == hit
    raise 'Invalid hit: ' + hit
  end
end
