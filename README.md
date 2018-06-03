# Ragnar

The backend for [Marketr](https://sonataxa.tech). Built on top of Phoenix/Elixir.

Marketr is a product made for investors who need curated information regarding stock options assets at the [BMF&Bovespa](http://www.bmfbovespa.com.br/pt_br/).
Its board contains the most negotiated assets at the market and brings all the needed information for trading, including a top-feature called "Rating".
Ratings are evaluated based on Artificial Intelligence and are the main purpose of this product because it achieves transparency, speed and accuracy
while choosing the best assets to invest money.

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

### Stack
This app was tested using Elixir 1.5+ and Postgres 9.x. There are apparent issues
with Ecto when tried to upgrade to Postgres 10.

### Docker usage
This app uses docker for containerization:

	# builds the web app and db container
	docker-compose build

	# starts up all containers and listent to http://localhost:4000
	docker-compose up

	# running commands inside web container (populate database)
	docker exec -it ragnar_web_1 bash
	=> iex -S mix
	=> Ragnar.BovespaFetcher.fetch_many!

	# stop everything
	docker-compose down

By default the database will write data to the local machine at `$(pwd)/.pgdata`.

### License
Ragnar is released under the [MIT License](https://opensource.org/licenses/MIT)
