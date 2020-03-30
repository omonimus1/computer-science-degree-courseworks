#pragma once

#include <string>
#include <vector>
#include "Node.h"

using namespace std;

class BinarySearchTree
{
public:
	// **Constructors and destructors**

	// Creates an empty binary tree
	BinarySearchTree();

	// Creates a binary search tree with an initial word to store
	BinarySearchTree(std::string word);

	// Creates a binary search tree by copying an existing tree
	BinarySearchTree(const BinarySearchTree &rhs);

	// Creates a binary search tree from a collection of existing words
	BinarySearchTree(const std::vector<std::string> &words);

	// Destroys (cleans up) the tree
	~BinarySearchTree();

	// **Methods that can be called on a BinarySearchTree object**

	// Adds a word to the tree
	void insert(std::string word);
	
	void insert_helper(Node **root, std::string word);

	// Checks if a word is in the tree
	bool exists(std::string word);

	// Checks recursevely inside the tree
	bool exists_helper(Node **root, std::string word);

	// Create recursevely a string that contains the tree in inorder way
	string inorder_helper(Node *root)const;

	// Create recursevely a string that contains the tree in preorder way
	std::string BinarySearchTree::preorder_helper(Node *root)const;

	// Create recursevely a string that contains the tree in postorder way
	std::string BinarySearchTree::postorder_helper(Node *root)const;

	// Creates a string representing the tree in alphabetical order
	std::string inorder() const;

	// Creates a string representing the tree in pre-order
	std::string preorder() const;

	// Creates a string representing the tree in post-order
	std::string postorder() const;

	// Increment counter for the application B
	void BinarySearchTree::incrementCounter(Node **root);



	// Read from file 
	void read_file()const;

	//void BinarySearchTree::copy_helper(Node **root, const Node *rhs)

	//void copyTreeHelper(const Node rhs.root, Node &root);
	
	//void incrementCounter();
	//Helper method to add a word in the BST
	// **Operator overloads**
	
	// Inserts a new word into the binary tree
	BinarySearchTree& operator+(std::string word);


	// Copy assignment operator
	BinarySearchTree& operator=(const BinarySearchTree &rhs);
	
private:
	//instance variables
	Node *root = nullptr; // Pointer to the root Node of the tree
};

