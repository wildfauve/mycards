$ -> 
	options_cards_time = {
		chart: { 
			renderTo: 'cards_chart', 
			defaultSeriesType: 'column'
		},
		title: { text: 'Cards Made by Week' },
		xAxis: {
			type: 'datetime',
		},
		yAxis: { title: { text: 'Number of Cards'}, min: 0 },
		tooltip: {
		      formatter: ->
		        Highcharts.dateFormat("%B %Y", @x) + ': ' + Highcharts.numberFormat(@y, 0)
		},
		series: [{
			type: 'area',
			name: 'Date Made'
			# 24hrs in milliseconds
			#pointInterval: 86400 * 1000,
			# milliseconds since the Epoch; in Ruby need Time.at(t/1000) to get this
			#pointStart: 1343174400000,
			data: [
	      [Date.UTC(1970,  9, 27), 0   ],
	      [Date.UTC(1970, 10, 10), 0.6 ],
	      [Date.UTC(1970, 10, 18), 0.7 ],
	      [Date.UTC(1970, 11,  2), 0.8 ],
	      [Date.UTC(1970, 11,  9), 0.6 ],
	      [Date.UTC(1970, 11, 16), 0.6 ],
	      [Date.UTC(1970, 11, 28), 0.67],
	      [Date.UTC(1971,  0,  1), 0.81],
	      [Date.UTC(1971,  0,  8), 0.78],
	      [Date.UTC(1971,  0, 12), 0.98],
	      [Date.UTC(1971,  0, 27), 1.84],
	      [Date.UTC(1971,  1, 10), 1.80],
	      [Date.UTC(1971,  1, 18), 1.80],
	      [Date.UTC(1971,  1, 24), 1.92],
	      [Date.UTC(1971,  2,  4), 2.49],
	      [Date.UTC(1971,  2, 11), 2.79],
	      [Date.UTC(1971,  2, 15), 2.73],
	      [Date.UTC(1971,  2, 25), 2.61],
	      [Date.UTC(1971,  3,  2), 2.76],
	      [Date.UTC(1971,  3,  6), 2.82],
	      [Date.UTC(1971,  3, 13), 2.8 ],
	      [Date.UTC(1971,  4,  3), 2.1 ],
	      [Date.UTC(1971,  4, 26), 1.1 ],
	      [Date.UTC(1971,  5,  9), 0.25],
	      [Date.UTC(1971,  5, 12), 0   ]
			 ]
			,
		}]
	}

#	chart = new Highcharts.Chart(options_cards_time)

	cardtime = $ ->
		$.ajax(
			url: '/charts/time.json'
			success: (plotdata) ->
				options_cards_time.series[0].data = plotdata.timeline.data
				#options_cards_time.series[0].pointStart = plotdata.timeline.interval_start
				#options_cards_time.series[0].pointInterval = plotdata.timeline.time_interval				
				chart = new Highcharts.Chart(options_cards_time)
		)
