class Dictionary
  def initialize(words)
    @words=words
  end
  def find_most_similar(term)
    @words.min_by do |word|
      levenshtein(word, term)
    end
  end

  private
  def levenshtein(str1, str2)
    m = str1.length
    n = str2.length
    return m if n == 0
    return n if m == 0
    d = Array.new(m+1) {Array.new(n+1)}

    (0..m).each {|i| d[i][0] = i}
    (0..n).each {|j| d[0][j] = j}
    (1..n).each do |j|
      (1..m).each do |i|
        d[i][j] = if str1[i-1] == str2[j-1]   # adjust index into string
                    d[i-1][j-1]               # no operation required
                  else
                    [ d[i-1][j]+1,            # deletion
                      d[i][j-1]+1,            # insertion
                      d[i-1][j-1]+1,          # substitution
                    ].min
                  end
      end
    end
    d[m][n]
  end
end
