# Ragnar

The backend for [Taxazeiro](https://sonataxa.tech). Built on top of Phoenix/Elixir.

### Description
Ragnar parses and exposes BMF&Bovespa data-related.
API for getting stocks listed at Bovespa, and their related calls/puts. Its core accounts with a [Neural Network](https://en.wikipedia.org/wiki/Artificial_neural_network) in order to learn and predict calls/puts to operate.

Some examples of API endpoints:

	GET /series
	GET /stocks
	GET /stocks/{share}/calls?serie=B
	GET /stocks/{share}/puts?serie=P

	GET /stocks/{share}/calls_for_operation?capital=10000&serie=A
	GET /stocks/{share}/puts_for_operation?capital=10000&serie=A


### License
Ragnar is released under the [MIT License](https://opensource.org/licenses/MIT)
