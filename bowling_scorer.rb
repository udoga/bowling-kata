class BowlingScorer
  def score(game)
    raise 'Invalid type' unless game.is_a?(String)
    return score_frames(game.split('|', -1))
  end

  def score_frames(frames)
    raise 'Invalid game' if frames.size() != 12 or not frames[10].empty?
    (0..9).map {|i| score_frame(frames[i], frames[i+1])}.sum()
  end

  def score_frame(frame, rest)
    return score_hit(frame) if frame == 'X'
    raise 'Invalid frame: ' + frame if frame.size != 2
    return 10 + score_hit(rest[0]) if score_hit(frame[0]) and frame[1] == '/'
    return score_hit(frame[0]) + score_hit(frame[1])
  end

  def score_hit(hit)
    return 0 if hit == '-'
    return 10 if hit == 'X'
    return hit.to_i if hit.to_i.to_s == hit
    raise 'Invalid hit: ' + hit
  end
end
