pkg load symbolic
# q1 0 0.5 0
syms q1
j1rz = [[cos(q1), -sin(q1), 0, 0]; [sin(q1), cos(q1), 0, 0]; [0, 0, 1, 0]; [0,0,0,1]]
j1tz = [[1, 0, 0, 0]; [0, 1, 0, 0]; [0, 0, 1, 0]; [0,0,0,1]]
j1tx = [[1, 0, 0, 0.5]; [0, 1, 0, 0]; [0, 0, 1, 0]; [0,0,0,1]]
j1rx = [[1, 0, 0, 0]; [0, 1, 0, 0]; [0, 0, 1, 0]; [0,0,0,1]]
line1 = j1rz*j1tz*j1tx*j1rx
# q2 0 0.3 0
syms q2
j2rz = [[cos(q2), -sin(q2), 0, 0]; [sin(q2), cos(q2), 0, 0]; [0, 0, 1, 0]; [0,0,0,1]]
j2tz = [[1, 0, 0, 0]; [0, 1, 0, 0]; [0, 0, 1, 0]; [0,0,0,1]]
j2tx = [[1, 0, 0, 0.3]; [0, 1, 0, 0]; [0, 0, 1, 0]; [0,0,0,1]]
j2rx = [[1, 0, 0, 0]; [0, 1, 0, 0]; [0, 0, 1, 0]; [0,0,0,1]]
line2 = j2rz*j2tz*j2tx*j2rx
T = line1*line2
