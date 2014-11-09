
defmodule EzcryptexTest do
  use ExUnit.Case

  @secret_key_base "i am the secret key base"
  @encrypt_salt "i am the encrypt salt"
  @sign_salt "i am the sign salt"

  test "encrypted message is not the same as the decrypted message" do
    decrypted = %{:foo => "bar"}
    assert decrypted != Ezcryptex.encrypt(encryptor(), decrypted)
  end

  test "encrypted message can be decrypted" do
    decrypted = %{:foo => "bar"}
    ezcryptex = encryptor()
    assert decrypted == Ezcryptex.decrypt(ezcryptex, Ezcryptex.encrypt(ezcryptex, decrypted))
  end

  test "wrong sign salt returns :error during decrypt" do
    decrypted = %{:foo => "bar"}
    ezcryptex = encryptor()
    bad_ezcryptex = Ezcryptex.new(@secret_key_base, @encrypt_salt, "foobar")
    {first, _second} = Ezcryptex.decrypt(bad_ezcryptex, Ezcryptex.encrypt(ezcryptex, decrypted))
    assert first == :error
  end

  test "wrong sign salt raises DecryptionError during decrypt!" do
    decrypted = %{:foo => "bar"}
    ezcryptex = encryptor()
    bad_ezcryptex = Ezcryptex.new(@secret_key_base, @encrypt_salt, "foobar")
    e = try do
      Ezcryptex.decrypt!(bad_ezcryptex, Ezcryptex.encrypt(ezcryptex, decrypted))
    rescue
      e in DecryptionError -> e
    end
    assert %DecryptionError{} == e
  end

  test "wrong encrypt salt returns :error during decrypt" do
    decrypted = %{:foo => "bar"}
    ezcryptex = encryptor()
    bad_ezcryptex = Ezcryptex.new(@secret_key_base, "foobar", @sign_salt)
    {first, _second} = Ezcryptex.decrypt(bad_ezcryptex, Ezcryptex.encrypt(ezcryptex, decrypted))
    assert first == :error
  end

  test "wrong encrypt salt raises DecryptionError during decrypt!" do
    decrypted = %{:foo => "bar"}
    ezcryptex = encryptor()
    bad_ezcryptex = Ezcryptex.new(@secret_key_base, "foobar", @sign_salt)
    e = try do
      Ezcryptex.decrypt!(bad_ezcryptex, Ezcryptex.encrypt(ezcryptex, decrypted))
    rescue
      e in DecryptionError -> e
    end
    assert %DecryptionError{} == e
  end

  defp encryptor do
    Ezcryptex.new(@secret_key_base, @encrypt_salt, @sign_salt)
  end
end
