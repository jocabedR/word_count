defmodule WordCount do
  import String

  def clean(word) do
    word = downcase(word)

    word = replace(word, "á", "a")
    word = replace(word, "é", "e")
    word = replace(word, "í", "i")
    word = replace(word, "ó", "o")
    word = replace(word, "ú", "u")

    word = replace(word, "\n", " ")
    word = replace(word, "/", " ")
    word = replace(word, ",", "")
    word = replace(word, ";", "")
    word = replace(word, ".", "")
    word = replace(word, ":", "")
    word = replace(word, "¿", "")
    word = replace(word, "?", "")
    word = replace(word, "¡", "")
    word = replace(word, "!", "")
    word = replace(word, "'", "")
    word = replace(word, "\"", "")
    word = replace(word, "(", "")
    word = replace(word, ")", "")
    word = replace(word, "-", "")
    word = replace(word, "", "")
    word = replace(word, "-", "")

    word
  end

  def count(path) do
    {:ok, text} = File.read(path)
    text_clean = clean(text)
    words = split(text_clean, " ", trim: true)
    counting(words, words)
  end

  def counting([], _), do: %{}
  def counting([h | t], words), do: Map.merge(%{h => countByWord(h, words)}, counting(t, words))

  def countByWord(_, [], counter), do: counter
  def countByWord(word, [h | t], counter \\ 0) do
     if word == h do
      countByWord(word, t, counter+1)
     else
      countByWord(word, t, counter)
     end
  end
end
