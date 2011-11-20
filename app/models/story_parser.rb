# encoding: UTF-8
require 'open-uri'
require 'nokogiri'

class StoryParser
  
  def initialize(source_id,page_id)
    @source = source_id
    @page = page_id
    @parse_url = Source.find(@source).parse_url
  end
  
  def fetch
    unless fetch_content.blank?
    {
      :title => fetch_title,
      :source_id => @source,
      :original_id => @page,
      :category => fetch_category,
      :author => fetch_author,
      :email => fetch_email,
      :content => fetch_content
    }
    end
  end
  
  protected
  
  def doc
    Nokogiri::HTML(open(@parse_url+@page.to_s))
  end
  
  def fetch_category
    doc.xpath('/html/body/center/table[2]/tr[3]/td[2]').text
  end
  
  def fetch_author
    str = doc.xpath('/html/body/center/table[2]/tr[4]/td[2]').text
    UnicodeUtils.downcase(str)
  end
  
  def fetch_title
    str = doc.xpath('/html/body/center/table[3]/tr/td/strong').text
    UnicodeUtils.downcase(str)
  end
  
  def fetch_content
    content = UnicodeUtils.downcase(doc.xpath('/html/body/center/table[3]/tr/td').text)
    merchan = UnicodeUtils.downcase(doc.xpath('/html/body/center/table[3]/tr/td/a').text)
    vote = UnicodeUtils.downcase(doc.xpath('/html/body/center/table[3]/tr/td/form').text)
    content_cleaned = content.sub(fetch_title, '').sub(merchan, '').sub(vote, '')
    content_striped = content_cleaned.strip.each_line.reject{|x| x.strip == ""}.join
    content_paragraphed = content_striped.gsub(/\n/,"\n\n").gsub('      ', '')
  end

  def fetch_email
    email = fetch_content.match(/\w+@[\w.-]+|\{(?:\w+, *)+\w+\}@[\w.-]+/)
    if email.blank?
      grab = doc.xpath('/html/body/center/table[2]/tr[4]/td[4]').text.downcase
      grab unless grab == "indisponível"
    else
      email.to_s.downcase
    end
  end
end
