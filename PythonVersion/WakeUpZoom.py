import time
import os.path
import calendar
from datetime import datetime

# Get current date & time
t = datetime.now()              
weekday = t.now().strftime("%a")
localtime = str(t.strftime("%-I:%M%p"))
print(weekday + " " + localtime)

# Get current working directory
cwd = os.path.dirname(os.path.realpath(__file__))

# If 'course.yer' is located within current directory:
# Deploy program
if os.path.isfile('course.yer'):
	with open('course.yer', 'r') as file:
            for line in file:
                print(line)
                #for word in line.split():
                #    print(word)
            file.close()

else:
        # Clear screen & sleep
	os.system('cls' if os.name == 'nt' else 'clear')
	time.sleep(1.5)

        # Print introduction message & create file named 'course.yer'
	print("First time setting up? I got you.")
	courses = open("course.yer", "w+")
	time.sleep(1.5)
	os.system('cls' if os.name == 'nt' else 'clear')

        # Ask user for input regarding total number of courses
	num_courses = int(input("How many classes do you want to add? "))
	time.sleep(1.5)
	os.system('cls' if os.name == 'nt' else 'clear')

        # Print examples of accepted formatting for requested user input
	print("Gotcha, here's some examples of the formatting")
	print("URL ---> http://garduno.me")
	print("Time ---> 9:30AM")
	print("Frequency ---> TTH")

        # 'routine' is an array that stores information for each given course
	routine = []
	i = 1
	while i != num_courses + 1:
                # Request url, time, frequency for each course
		print("\n\n************* Course #" + str(i) + " *************")
		url = str(input("URL ---> "))
		clk = str(input("Time ---> "))
		freq = str(input("Frequency ---> "))
		courses.write(freq + " " + clk + " " + url + "\n")
		i += 1
		routine.append(url + " @ " + clk + " every " + freq)

	time.sleep(1)
	os.system('cls' if os.name == 'nt' else 'clear')

        # Output courses
	print("Here's the shit you gave me btw:")
	for x in routine:
		print("--> " + x)

	print("\n\nCool you're done. If you move the python file, make sure to also move the courses file (in this folder: " + cwd)
	time.sleep(1)
	os.system('cls' if os.name == 'nt' else 'clear')
        
	print("\n\n Once you run this program again, you'll be set!")
	courses.close()
