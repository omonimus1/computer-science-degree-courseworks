//Davide Pollicino -> 40401270
// 08/03/2019

#pragma once

//Free the memory to avoid memory leeks


#include "BinarySearchTree.h"
#include "Node.h"
#include <string>
#include <vector>
#include <iostream>


using namespace std;
// Free the memory used by the tree

void destroy_helper(Node **root);


void incrementCounter_helper(Node **root);

Node* copy_helper(Node *rhs);


// **Constructors **
//Creates an empty binary search tree
BinarySearchTree::BinarySearchTree()
{

}

// create a binary search tree with an itial word to store. 
BinarySearchTree::BinarySearchTree(std::string word)
{	
	root = new Node;
	root-> word = word;
	root->left = nullptr;
	root->right = nullptr;
}


// Creates a binary search tree by copying an existing binary
//search tree. This must be a deep copy, not a reference.

BinarySearchTree::BinarySearchTree(const BinarySearchTree &rhs)
{
<<<<<<< HEAD
	copy_helper(&root, rhs);
}


void BinarySearchTree::copy_helper(Node **root,const BinarySearchTree &rhs)
{

	*root = new Node;
	if (rhs > (*root2)->word)
		copy_helper(&(*root)->right, rhs);
	else if (word < (*root)->word)
		copy_helper(&(*root)->left, rhs);
	else
	{
		 (*root)->word = rhs.word;		
	}

}

=======
	root = copy_helper(rhs.root);
	
}

Node* copy_helper(Node *rhs) {
	
	if (rhs == nullptr)
		return nullptr;
	else
	{
		Node* tree2 = new Node;
		tree2->word = rhs->word;
		tree2->left = copy_helper(rhs->left);
		tree2->right = copy_helper(rhs->right);
		return tree2;
	}
}



>>>>>>> 1a3bab51c40db85b4613413d12eed176bc481d02

// Create a BST from a vector of words
BinarySearchTree::BinarySearchTree(const vector<std::string> &words)
{
	for (int i = 0; i < words.size(); i++)
		this->insert(words[i]);
}
 


// **Methods**
// Returns true if the word is in the tree, false otherwise.
bool BinarySearchTree::exists(std::string word)
{
	if(exists_helper(&root, word))
		(*root).count = (*root).count+1;

	return exists_helper(&root, word);
}

bool BinarySearchTree::exists_helper(Node **root, std::string word)
{
	if (*root == nullptr)
	{
		return false;

	}
	else
	{
		if (word > (*root)->word)
			return exists_helper(&(*root)->right, word);
		else if (word < (*root)->word)
			return exists_helper(&(*root)->left, word);
		else
		 {
			 if (word == (*root)->word) {
				 return true;
			 }
			 
		 }
		 return false;
	}
	return false;
}

// Adds a word to the binary search tree. If the word already exists in the tree then nothing happens.
void BinarySearchTree::insert(std::string word)
{
	if (!exists(word))
		insert_helper(&root, word);
}

// Function for check inside all the tree recursively
void BinarySearchTree::insert_helper(Node **root, std::string word) 
{
	if (*root == nullptr)
	{
		//create new root
		*root	 = new Node;
		//set new value
		(*root)->word = word;
		(*root)->left = nullptr;
		(*root)->right = nullptr;
	}
	else {
		if (word < (*root)->word)
			insert_helper(&(*root)->left, word);
		else if(word > (*root)-> word)
			insert_helper(&(*root)->right, word);
		else {
			(*root)->word = word;
			(*root)->count++;
		}
		
	}
}


void incrementCounter(Node **root)
{
	//(*root)->count++;
}


// Destructor for a binary search tree. Releases the memory occupied by all of its roots.
BinarySearchTree::~BinarySearchTree()
{
	destroy_helper(&root);
}


void destroy_helper(Node **root)
{
	if (*root != nullptr)
	{
		destroy_helper((&(*root)->left));
		destroy_helper((&(*root)->right));
		delete *root;
	}
	*root = nullptr;
}



// Generates a string containing the words in the tree in alphabetic order.
string BinarySearchTree::inorder()const
{
	string word = inorder_helper(root);
	if(word.length() > 1)
	{
		word.pop_back();
	}
	return word;
}

// Create recursevely a string that contains the tree in inorder way
string BinarySearchTree::inorder_helper(Node *root)const
{
	if (root == nullptr)
	{
		return "";
	}
	else 
	{
		return (inorder_helper(root->left) + root->word  + " " + inorder_helper(root->right));
	}
}




// Generates a string containing the words in the tree in pre - order fashion.
string BinarySearchTree::preorder()const
{
	string word = preorder_helper(root);
	if(word.length() > 1)
	{
		word.pop_back();
	}
	return word;
}

// Create recursevely a string that contains the tree in preorder way
string BinarySearchTree::preorder_helper(Node *root)const
{
	if(root == nullptr)
	{
		return "";
	}
	else {
		return  (root->word + " " + preorder_helper(root->left) + preorder_helper(root->right));
	}
}

// Generates a string containing the words in the tree in postorder fashion. 
string BinarySearchTree::postorder()const
{
	string word = postorder_helper(root);
	if(word.length() > 1)
	{
		word.pop_back();
	}
	return word;

}
// Create recursevely a string that contains the tree in postorder way
string BinarySearchTree::postorder_helper(Node *root)const
{
	if (root == nullptr)
	{
		return "";
	}
	else 
	{
		return (postorder_helper(root->left) + postorder_helper(root->right) + root->word  + " ");
	}
}


	// **Operator overloads**

BinarySearchTree& BinarySearchTree::operator+(string word)
{
	this->insert(word);
	return *this; // returns a reference to the modified tree
}


BinarySearchTree& BinarySearchTree::operator=(const BinarySearchTree &rhs)
{
	if (this != &rhs)
	{	
		destroy_helper(&(this)->root);
		root = copy_helper( rhs.root);
		
	}	
	return *this;
}

