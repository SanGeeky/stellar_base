defmodule StellarBase.XDR.Hash do
  @moduledoc """
  Representation of Stellar `Hash` type.
  """
  alias StellarBase.XDR.Opaque32

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{value: binary()}

  defstruct [:value]

  @spec new(value :: binary()) :: t()
  def new(value), do: %__MODULE__{value: value}

  @impl true
  def encode_xdr(%__MODULE__{value: value}) do
    Opaque32.encode_xdr(%Opaque32{opaque: value})
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value}) do
    Opaque32.encode_xdr!(%Opaque32{opaque: value})
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case Opaque32.decode_xdr(bytes) do
      {:ok, {%Opaque32{opaque: value}, rest}} -> {:ok, {new(value), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%Opaque32{opaque: value}, rest} = Opaque32.decode_xdr!(bytes)
    {new(value), rest}
  end
end
