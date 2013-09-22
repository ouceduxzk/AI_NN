colors = [['red', 'green', 'green', 'red' , 'red'],
          ['red', 'red', 'green', 'red', 'red'],
          ['red', 'red', 'green', 'green', 'red'],
          ['red', 'red', 'red', 'red', 'red']]

measurements = ['green', 'green', 'green' ,'green', 'green']


motions = [[0,0],[0,1],[1,0],[1,0],[0,1]]

sensor_right = 0.7

p_move = 0.8

def show(p):
    for i in range(len(p)):
        print p[i]

#DO NOT USE IMPORT
#ENTER CODE BELOW HERE
#ANY CODE ABOVE WILL CAUSE
#HOMEWORK TO BE GRADED
#INCORRECT
p= [[0.05 for i in range(len(colors[0]))] for j in range(len(colors))]


        
def sense(p, Z):
    q= [[0.0 for i in range(len(colors[0]))] for j in range(len(colors))]
    s= 0.0
    for i in range(len(colors)):
        for j in range(len(colors[i])):
            hit = (Z == colors[i][j])
            q[i][j] = (p[i][j] * (hit * sensor_right + (1-hit) * (1-sensor_right)))
            s = s+ q[i][j]
    for i in range(len(q)):
        for j in range(len(q[i])):
            q[i][j] = q[i][j] /s
    return q

def move(p, U):
    q= [[0.0 for i in range(len(colors[0]))] for j in range(len(colors))]

    for i in range(len(p)):
        for j in range(len(p[i])):
            s = p_move * p[(i-U[0]) % len(p)][(j-U[1])%len(p[i])] + (1-p_move)*p[i][j]
            q[i][j]= s
    return q


for k in range(len(measurements)):
    

    p = move(p, motions[k])
    p = sense(p, measurements[k])
# move first and then sense, 

#Your probability array must be printed 
#with the following code.

show(p)





