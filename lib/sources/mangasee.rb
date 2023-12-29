# frozen_string_literal: true

module Sources
  class Mangasee < Base
    private

    def base_url = "https://mangasee123.com/manga/"

    def extract_image(document) = document.css("img.img-fluid.bottom-5")[0]["src"]

    def extract_name(document) = document.css("h1")[0].text

    def extract_last_chapter(document)
      script_tag = document.css("script").find { _1.text.include?("function MainFunction") }
      return manga.last_chapter unless script_tag.present?

      script = script_tag.text
      regex = /vm\.Chapters = ([^;]*)/

      if (match = regex.match(script))
        json = JSON.parse(match[1])
        last_chapter = json.first

        type = last_chapter["Type"]
        chapter = last_chapter["Chapter"]
        chapter_number = clean_chapter_number(chapter)

        name = "#{type} #{chapter_number}"

        chapter_name = last_chapter["ChapterName"]
        return "#{name}: #{chapter_name}" if chapter_name.present?

        name
      else
        manga.last_chapter
      end
    end

    def clean_chapter_number(chapter)
      chapter_regex = /^0+/
      part_one = chapter[1...-1].sub(chapter_regex, "")
      part_two = chapter.last.to_i

      return part_one if part_two == 0 && part_one.present?
      # For chapters that have a chapter number of 0
      return "0" if part_two == 0 && !part_one.present?
      return "#{part_one}.#{part_two}"
    end
  end
end
