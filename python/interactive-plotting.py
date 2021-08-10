from matplotlib import pyplot as plt
import numpy as np

plt.ion()
fig = plt.figure()
ax = fig.add_subplot(111)
ax.set_ylim([-1.,1.])
ax.grid()

nvalues = 10
x = np.linspace( 0, 10, nvalues )
y = np.zeros( nvalues, dtype='float64' )

# Plot the initial data
line1, = ax.plot(x, y, 'b-')

for i in range(50):
    ynew = (np.random.rand(1)-0.5)*2
    y[:-1] = y[1:]
    y[-1] = ynew

    line1.set_ydata( y )
    fig.canvas.draw()
    fig.canvas.flush_events()
    plt.pause(0.1)
