defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards 
  """
  
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Returns a shuffled deck of cards
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end


  @doc """
    Determines whether a deck contains a given card

  ## Examples


      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")  
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end


  @doc """
    Divides a deck into a hand a the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples
  

      iex> deck = Cards.create_deck
      iex> Cards.deal(deck, 1)
      {["Ace of Spades"],["Two of Spades", "Three of Spades", "Four of Spades",
       "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
       "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
       "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
       "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]}
      

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end


  @doc """
    Saves the deck to a file
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end


  @doc """
    Loads a deck from a file
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "There is no such filename!"
    end
  end


  @doc """
    Creates a deck, shuffles it and creates a hand of a specified size
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
