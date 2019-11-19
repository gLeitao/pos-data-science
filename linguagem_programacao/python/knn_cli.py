from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from modelos.knn_class import KNN

X, y = load_iris(return_X_y=True)

X_teste, X_train, y_teste, y_train = train_test_split(X, y, test_size=0.2, random_state=1)

clf = KNN(k=5)
clf.fit(X_train, y_train)
predicoes = clf.predict(X_teste)

print(predicoes)