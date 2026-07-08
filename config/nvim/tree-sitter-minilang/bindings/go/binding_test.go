package tree_sitter_minilang_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_minilang "github.com/sidequestboy/tree-sitter-minilang/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_minilang.Language())
	if language == nil {
		t.Errorf("Error loading Minilang grammar")
	}
}
