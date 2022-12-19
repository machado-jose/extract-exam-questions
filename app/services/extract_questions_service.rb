class ExtractQuestionsService
  def initialize(filename:)
    @filename = filename
    @results = []
  end

  def run
    read_file
    apply_strategy
    results
  end

  private

  attr_accessor :reader, :results
  attr_reader :filename

  def read_file
    @reader = PDF::Reader.new(filename).pages.map(&:text)
  end

  def apply_strategy
    reader.each do |page|
      next unless page.match(/^Questão/).present?

      results << Enem::DigitalLayout.new(page: page).extract
    end
  end
end

