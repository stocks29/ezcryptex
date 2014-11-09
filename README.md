Ezcryptex
=========

An [Elixir][] library for encrypting/decrypting, signing/verifying data. Really, this is just a super thin layer on top of [Cryptex][].

[Elixir]: http://elixir-lang.org
[Cryptex]: https://github.com/scrogson/cryptex

## Usage

```elixir
# Secrets
secret_key_base = "072d1e0157c008193fe48a670cce031faa4e..."
encrypted_cookie_salt = "encrypted cookie"
encrypted_signed_cookie_salt = "signed encrypted cookie"

# Stuff we want to encrypt
data = %{current_user: %{name: "José"}}

# Actual code to encrypt/sign and decrypt/verify
ezcryptex = Ezcryptex.new(secret_key_base, encrypted_cookie_salt, encrypted_signed_cookie_salt)
ciphertext = Ezcryptex.encrypt!(ezcryptex, data)
decrypted = Ezcryptex.decrypt!(ezcryptex, ciphertext)
decrypted.current_user.name # => "José"
```

## License

The MIT License (MIT)

Copyright (c) 2014 Bob Stockdale

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.