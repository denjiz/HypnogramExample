import sys

data_point_interval_in_seconds = 30

def generate_cvs_lines(phase_input, phase_start_timestamp):
	components = phase_input.split(":")
	phase = components[0]
	duration_in_minutes = int(components[1])

	data_point_count = int(duration_in_minutes * 60 / data_point_interval_in_seconds)
	timestamps = [phase_start_timestamp + i * data_point_interval_in_seconds for i in range(data_point_count)]
	cvs_lines = [f"{timestamp},{phase}" for timestamp in timestamps]
	
	next_phase_start_timestamp = timestamps[-1] + data_point_interval_in_seconds

	return (cvs_lines, next_phase_start_timestamp)
	
start_timestamp = int(sys.argv[1])
phases_input = sys.argv[2]
phases_input_array = phases_input.split(",")
output_file_path = sys.argv[3]

csv_lines = ["Timestamp,Phase"]
next_phase_start_timestamp = start_timestamp
for phase_input in phases_input_array:
	(phase_csv_lines, next_phase_start_timestamp) = generate_cvs_lines(phase_input, next_phase_start_timestamp)
	csv_lines += phase_csv_lines

with open(output_file_path,"w") as csv_file:
	csv_file.writelines(f"{csv_line}\n" for csv_line in csv_lines)
