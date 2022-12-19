class Enem::DigitalLayout
  def initialize(page:)
    @page = page
    @result = {}
  end

  def extract
    extract_title
    extract_statement
    extract_alternatives
    result
  end

  private

  attr_accessor :page, :result

  def extract_title
    title_sentence = page.scan(/^Questão \d{2} - .*/).first
    return if title_sentence.nil?

    result[:number_question] = title_sentence.scan(/\d{2}/).first
    result[:area] = title_sentence.scan(/(?<=- ).*/).first
  end

  def extract_statement
    statement = page.gsub(/^Questão \d{2} - .*\n\n\n/, '')
    alternative_content = statement.split(/(\n{5})/).last
    statement = statement.gsub(alternative_content, '')
    result[:statement] = statement.blank? ? nil : statement.strip
  end

  def extract_alternatives
    alternative_content = page.split(/(\n{5})/).last
    alternative_content = alternative_content.split(/\n{3,4}/)
    result[:alternatives] = []
    alternative_content.each do |alternative|
      result[:alternatives] << alternative.lstrip.split(/^\w/).last.strip
    end
  end
end

