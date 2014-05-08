# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Security::Application.config.secret_key_base = '0eda2a2b36fd6e94d835ae75945625a3ea414e8885dd852e277dc0cbff29d0f9a99a965ebd347fae4033e7cf9cc3bc50c7295a94a28ad59b50f84fbbe17e6ae8'
