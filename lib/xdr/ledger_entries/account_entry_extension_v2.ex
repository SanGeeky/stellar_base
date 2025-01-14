defmodule StellarBase.XDR.AccountEntryExtensionV2 do
  @moduledoc """
  Representation of Stellar's ledger AccountEntryExtensionV2
  """

  alias StellarBase.XDR.{UInt32, AccountIDList, Ext}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 num_sponsored: UInt32,
                 num_sponsoring: UInt32,
                 signer_sponsoring_ids: AccountIDList,
                 ext: Ext
               )

  @type t :: %__MODULE__{
          num_sponsored: UInt32.t(),
          num_sponsoring: UInt32.t(),
          signer_sponsoring_ids: AccountIDList.t(),
          ext: Ext.t()
        }

  defstruct [:num_sponsored, :num_sponsoring, :signer_sponsoring_ids, :ext]

  @spec new(
          num_sponsored :: UInt32.t(),
          num_sponsoring :: UInt32.t(),
          signer_sponsoring_ids :: AccountIDList.t(),
          ext :: Ext.t()
        ) :: t()
  def new(
        %UInt32{} = num_sponsored,
        %UInt32{} = num_sponsoring,
        %AccountIDList{} = signer_sponsoring_ids,
        %Ext{} = ext
      ),
      do: %__MODULE__{
        num_sponsored: num_sponsored,
        num_sponsoring: num_sponsoring,
        signer_sponsoring_ids: signer_sponsoring_ids,
        ext: ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        num_sponsored: num_sponsored,
        num_sponsoring: num_sponsoring,
        signer_sponsoring_ids: signer_sponsoring_ids,
        ext: ext
      }) do
    [
      num_sponsored: num_sponsored,
      num_sponsoring: num_sponsoring,
      signer_sponsoring_ids: signer_sponsoring_ids,
      ext: ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        num_sponsored: num_sponsored,
        num_sponsoring: num_sponsoring,
        signer_sponsoring_ids: signer_sponsoring_ids,
        ext: ext
      }) do
    [
      num_sponsored: num_sponsored,
      num_sponsoring: num_sponsoring,
      signer_sponsoring_ids: signer_sponsoring_ids,
      ext: ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            num_sponsored: num_sponsored,
            num_sponsoring: num_sponsoring,
            signer_sponsoring_ids: signer_sponsoring_ids,
            ext: ext
          ]
        }, rest}} ->
        {:ok, {new(num_sponsored, num_sponsoring, signer_sponsoring_ids, ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         num_sponsored: num_sponsored,
         num_sponsoring: num_sponsoring,
         signer_sponsoring_ids: signer_sponsoring_ids,
         ext: ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(num_sponsored, num_sponsoring, signer_sponsoring_ids, ext), rest}
  end
end
