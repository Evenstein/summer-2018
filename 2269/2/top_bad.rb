# :reek:DuplicateMethodCall
# :reek:NestedIterators
# :reek:FeatureEnvy
# :reek:TooManyStatements
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/LineLength
def get_top_bad(top, destination)
  rapers = get_rapers destination

  rapers.each do |_key, value|
    value.file_name.each do |file|
      hash = word_counter(destination + '/' + file)
      value.add_words_count hash[:total]
      value.add_bad_words hash[:bad]
      value.words_round = hash[:round]
    end
  end

  delimiter = 1
  rapers.sort_by { |_k, val| [-val.bad_words] }.each do |_key, value|
    break if delimiter > top
    average = value.bad_words.fdiv(value.battles).round(2)
    result = value.name.ljust(25) + ' | ' +
             value.battles.to_s.ljust(2) + ' ' +
             RuPropisju.choose_plural(value.battles, 'баттл', 'баттла', 'баттлов').ljust(7) + ' | ' +
             value.bad_words.to_s.ljust(4) + ' ' +
             RuPropisju.choose_plural(value.bad_words, 'нецензурное', 'нецензурных', 'нецензурных') + ' ' +
             RuPropisju.choose_plural(value.bad_words, 'слово', 'слова', 'слов').ljust(5) + ' | ' +
             average.to_s.ljust(6) + ' ' +
             RuPropisju.choose_plural(average, 'слово', 'слова', 'слова') + ' на баттл | '.ljust(12) +
             value.words_round.to_s.ljust(5) + ' ' +
             RuPropisju.choose_plural(value.words_round, 'слово', 'слова', 'слов').ljust(5) +
             ' в раунде |'.ljust(11)
    puts result
    delimiter += 1
  end
end
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength