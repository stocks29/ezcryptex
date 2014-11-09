defmodule EncryptionError do
  defexception message: "Error encrypting or signing"
end

defmodule DecryptionError do
  defexception message: "Error decrypting or verifying"
end

defmodule Ezcryptex do
  defstruct encryptor: nil

  def new(secret_key_base, encrypt_salt, sign_salt) do
    %Ezcryptex{
      encryptor: message_encryptor(
        keygen(secret_key_base, encrypt_salt),
        keygen(secret_key_base, sign_salt))
    }
  end

  def encrypt(ezcryptex, data) do
    try do
      encrypt!(ezcryptex, data)
    rescue
      e in EncryptionError -> {:error, e.message}
    end
  end

  def encrypt!(%Ezcryptex{encryptor: encryptor}, data) do
    try do
      Cryptex.MessageEncryptor.encrypt_and_sign(encryptor, data)
    rescue
      _e -> raise EncryptionError
    end
  end

  def decrypt(ezcryptex, cipher) do
    try do
      decrypt!(ezcryptex, cipher)
    rescue
      e in DecryptionError -> {:error, e.message}
    end
  end

  def decrypt!(%Ezcryptex{encryptor: encryptor}, cipher) do
    try do
      Cryptex.MessageEncryptor.decrypt_and_verify(encryptor, cipher)
    rescue
      _e -> raise DecryptionError
    end
  end

  defp message_encryptor(secret, sign_secret) do
    Cryptex.MessageEncryptor.new(secret, sign_secret)
  end

  defp keygen(secret_key_base, salt) do
    Cryptex.KeyGenerator.generate(secret_key_base, salt)
  end


end
