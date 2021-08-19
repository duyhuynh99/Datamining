unit kdtree;
interface
// program kdtree;
uses crt, math, sysutils, classes, strutils;
type
    PPoint = array[0..2] of real;
    Tree = ^TreeNode;
    TreeNode = record
        value: PPoint;
        left: Tree;
        right: Tree;
    end;
    ppt_arr = array of PPoint;
    int_arr = array of Int32;
var result: int_arr;
function create_kdtree(root: Tree; arr: ppt_arr; low, high: Int32): Tree;
function query(root: Tree; p: PPoint; radius: real): int_arr;

implementation
Procedure QSort(numbers: ppt_arr; left : Int32; right : Int32; axis: Int32);
Var 
	pivot: PPoint; 
    l_ptr, r_ptr, split : Int32;

Begin
	l_ptr := left;
	r_ptr := right;
	pivot := numbers[left];

	While (left < right) do
	Begin
		While ((numbers[right][axis] >= pivot[axis]) AND (left < right)) do
			right := right - 1;

		If (left <> right) Then
		Begin
			numbers[left] := numbers[right];
			left := left + 1;
		End;

		While ((numbers[left][axis] <= pivot[axis]) AND (left < right)) do
			left := left + 1;

		If (left <> right) Then
		Begin
			numbers[right] := numbers[left];
			right := right - 1;
		End;
	End;

	numbers[left] := pivot;
	split := left;
	left := l_ptr;
	right := r_ptr;

	If (left < split) Then
		QSort(numbers, left, split-1, axis);

	If (right > split) Then
		QSort(numbers, split+1, right, axis);
End;
function create_kdtree_(root: Tree; arr: ppt_arr; low, high, depth: Int32): Tree;
var axis, median: Int32;
begin
    if low > high then
    begin
        create_kdtree_ := nil;
    end
    else
    begin
        if root = nil then
        begin
            new(root);
            root^.left := nil;
            root^.right := nil;
        end;
        axis := depth mod 2;
        qsort(arr, low, high, axis);
        median := (low + high) div 2;
        root^.value := arr[median];
        root^.left := create_kdtree_(root^.left, arr, low, median - 1, depth + 1);
        root^.right := create_kdtree_(root^.right, arr, median + 1, high, depth + 1);
        create_kdtree_ := root; 
    end;
end;
function create_kdtree(root: Tree; arr: ppt_arr; low, high: Int32): Tree;
begin
    create_kdtree := create_kdtree_(root, arr, low, high, 0);
end;
function distance(p1, p2: PPoint): real;
begin
    distance := power(p1[0] - p2[0], 2) + power(p1[1] - p2[1], 2);
end;
function manhattan(p1, p2: PPoint; axis: Int32): real;
begin
    manhattan := power(p1[axis] - p2[axis], 2);
end;
procedure radius_search(root: Tree; p: PPoint; radius: real; depth: Int32);
var axis: Int32;
    current_PPoint: PPoint;
    nearer_branch, further_branch: Tree;
begin
    if root <> nil then
    begin
        axis := depth mod 2;
        current_PPoint := root^.value;
        if distance(current_PPoint, p) <= radius then
        begin
            setlength(result, length(result) + 1);
            result[length(result) - 1] := round(current_PPoint[2]);
        end;
        if current_PPoint[axis] < p[axis] then
        begin
            nearer_branch := root^.right;
            further_branch := root^.left;
        end
        else
        begin
            nearer_branch := root^.left;
            further_branch := root^.right;
        end;
        radius_search(nearer_branch, p, radius, depth + 1);
        if manhattan(current_PPoint, p, axis) <= radius then
        begin
            radius_search(further_branch, p, radius, depth + 1);
        end;    
    end;
end;
function query(root: Tree; p: PPoint; radius: real): int_arr;
begin
    setlength(result, 0);
    radius_search(root, p, radius, 0);
    query := result;
end;

function test_fn(kd_arr: ppt_arr; p: PPoint; radius: real): int_arr;
var i : Int32;
begin
    setlength(result, 0);
    writeln(length(result));
    for i := 0 to length(kd_arr) - 1 do
    begin
        if distance(kd_arr[i], p) <= radius then
        begin
            setlength(result, length(result) + 1);
            result[length(result) - 1] := round(kd_arr[i][2]);
        end;
    end;
    test_fn := result;
end;

begin

end.