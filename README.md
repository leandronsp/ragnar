# Ragnar

The backend for [Taxazeiro](https://sonataxa.tech). Built on top of Phoenix/Elixir.

### Description
Ragnar parses and exposes BMF&Bovespa data-related.
API for getting stocks listed at Bovespa and their related calls/puts. 

Its core uses [Morphine](https://github.com/leandronsp/morphine), a Neural Network used to learn and predict scores based on share rate, balance, volatiliy and trades. 

Some examples of API endpoints:

	GET /series
	GET /stocks
	GET /stocks/{share}/calls?serie=B
	GET /stocks/{share}/puts?serie=P

	GET /stocks/{share}/calls/evaluated?capital=10000&serie=A
	GET /stocks/{share}/puts/evaluated?capital=10000&serie=A
	
	### Training the neural network!
	POST /network/train
	inputs: [[0, 1, 0], [0, 0, 1], [0, 0, 0]]
	targets: [[1, 0, 0]]


### License
Ragnar is released under the [MIT License](https://opensource.org/licenses/MIT)
