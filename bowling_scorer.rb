class BowlingScorer
  def score(game)
    raise 'Invalid type' unless game.is_a?(String)
    return score_inputs(game.split('|', -1))
  end

  def score_inputs(inputs)
    raise 'Invalid game' if inputs.size() != 12 or not inputs[10].empty?
    return score_frames(inputs[0..9])
  end

  def score_frames(frames)
    total = 0
    frames.each { |frame| total += score_frame(frame) }
    return total
  end

  def score_frame(frame)
    return 10 if frame == 'X'
    raise 'Invalid frame: ' + frame if frame.size != 2
    first_hit = score_hit(frame[0])
    return frame[1] == '/'? 10 : (first_hit + score_hit(frame[1]))
  end

  def score_hit(hit)
    raise 'Invalid hit: ' + hit if hit != '-' and hit.to_i.to_s != hit
    return hit.to_i
  end
end
