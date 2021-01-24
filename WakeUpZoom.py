import os.path
import time

cwd = os.path.dirname(os.path.realpath(__file__))

if os.path.isfile('course.yer'):
	print("Yeah this bitch is a file")

else:
	os.system('cls' if os.name == 'nt' else 'clear')
	time.sleep(1.5)
	print("First time setting up? I got you.")
	courses = open("course.yer", "w+")
	time.sleep(2)
	os.system('cls' if os.name == 'nt' else 'clear')
	num_courses = int(input("How many classes do you want to add? "))
	os.system('cls' if os.name == 'nt' else 'clear')
	time.sleep(1.5)
	print("Gotcha, here's some examples of the formatting")
	print("URL ---> http://garduno.me")
	print("Time ---> 9:30AM")
	print("Frequency ---> TTH")


	routine = []
	i = 1
	while i != num_courses + 1:
		print("\n\n************* Course #" + str(i) + " *************")
		url = str(input("URL ---> "))
		clk = str(input("Time ---> "))
		freq = str(input("Frequency ---> "))
		courses.write(url + " " + clk + " " + freq + "\n")
		i += 1
		routine.append(url + " @ " + clk + " every " + freq)
	os.system('cls' if os.name == 'nt' else 'clear')
	time.sleep(1)

	print("Here's the shit you gave me btw:")
	for x in routine:
		print("--> " + x)

	print("\n\nCool you're done. If you move the python file, make sure to also move the courses file (in this folder: " + cwd)
	courses.close()
