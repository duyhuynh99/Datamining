program dbscan;
uses crt, math, sysutils, classes, strutils, kdtree, dateutils;
type 
    Point = record
        x: real;
        y: real;
        cluster_id: longint;
end;
type
    pt_arr = array of Point;

var arr: pt_arr;
    eps: real;
    min_pts: longint;
    kd_arr: ppt_arr;
    root: Tree;
function distance(p1, p2: Point): real;
begin
    distance := power(p1.x - p2.x, 2) + power(p1.y - p2.y, 2);
end;
function collect_a_cluster(p: Point): int_arr;
var idx_arr: int_arr;
    i, count: longint;
begin
    count := 0;
    setlength(idx_arr, length(arr));
    for i := 0 to length(arr) - 1 do
    begin
        if distance(p, arr[i]) <= eps then
        begin
            idx_arr[count] := i;
            count := count + 1;
        end;
    end;
    setlength(idx_arr, count);
    collect_a_cluster := idx_arr;
end;
function expand_cluster(p: Point; cluster_id: longint): longint;
var neighbors, new_pts: int_arr;
    core_idx, i, j: longint;
    ppt: PPoint;
begin
    // neighbors := collect_a_cluster(p);
    ppt[0] := p.x;
    ppt[1] := p.y;
    neighbors := query(root, ppt, eps);
    if length(neighbors) < min_pts then
        begin
            p.cluster_id := -1;
            expand_cluster := 0;
        end
    else
        begin
            for i := 0 to length(neighbors) - 1 do
            begin
                arr[neighbors[i]].cluster_id := cluster_id;
                if (arr[neighbors[i]].x = p.x) and (arr[neighbors[i]].y = p.y) then
                    core_idx := i;
            end;
            neighbors[core_idx] := neighbors[length(neighbors) - 1];
            setlength(neighbors, length(neighbors) - 1);
            i := 0;
            while i < length(neighbors) do
            begin
                // new_pts := collect_a_cluster(arr[neighbors[i]]);
                ppt[0] := arr[neighbors[i]].x;
                ppt[1] := arr[neighbors[i]].y;
                new_pts := query(root, ppt, eps);
                if length(new_pts) >= min_pts then
                begin
                    for j := 0 to length(new_pts) - 1 do
                        if arr[new_pts[j]].cluster_id < 1 then
                        begin
                            if arr[new_pts[j]].cluster_id = 0 then
                            begin
                                setlength(neighbors, length(neighbors) + 1);
                                neighbors[length(neighbors) - 1] := new_pts[j];
                            end;
                            arr[new_pts[j]].cluster_id := cluster_id;
                        end;
                end;
                i := i + 1;
            end;
            expand_cluster := 1;
        end;
end;
procedure dbscan();
var cluster_id, i: longint;
begin
    cluster_id := 1;
    for i := 0 to length(arr) - 1 do
        if arr[i].cluster_id = 0 then
            if expand_cluster(arr[i], cluster_id) <> 0 then
            begin
                cluster_id := cluster_id + 1;
            end;
end;
var filein: textfile;
    s, num1, num2: string;
    idx: longint;
    i: longint;
    fileIdx: integer;
    p: Point;
    fileout: textfile;
    kd_p: PPoint;
var FromTime, ToTime: TDateTime;    
begin
    // read file config
    assign(filein, 'config.txt');
    reset(filein);
    readln(filein, s);
    idx := pos(':', s);
    min_pts := strtoint(copy(s, idx + 1, length(s) - idx));
    readln(filein, s);
    idx := pos(':', s);
    eps := strtofloat(copy(s, idx + 1, length(s) - idx));
    eps := eps * eps;
    fileIdx := 0;
    close(filein);
    for fileIdx := 1 to 6 do
    begin
        assign(filein, Concat('data',IntToStr(fileIdx),'.txt'));
        reset(filein);
        readln(filein, s);
        setlength(arr, strtoint(s));
        setlength(kd_arr, strtoint(s));
        i := 0;
        while not eof(filein) do
        begin
            readln(filein, s);
            idx := pos(',', s);
            num1 := copy(s, 1, idx - 1);
            num2 := copy(s, idx + 2, length(s) - idx - 1);
            p.x := strtofloat(num1);
            p.y := strtofloat(num2);
            p.cluster_id := 0;
            kd_p[0] := p.x;
            kd_p[1] := p.y;
            kd_p[2] := i;
            arr[i] := p;
            kd_arr[i] := kd_p;
            i := i + 1;
        end;
        writeln ('Start time : ',TimeToStr(Time));
        FromTime := Now;
        root := nil;
        root := create_kdtree(root, kd_arr, 0, length(kd_arr) - 1);
        dbscan();
        writeln ('End time : ',TimeToStr(Time));
        ToTime := Now;
        writeln('TEST CASE ',IntToStr(fileIdx),':', FormatDateTime('hh.nn.ss.zzz', ToTime - FromTime));
        assign(fileout, Concat('preds',IntToStr(fileIdx),'.txt'));
        rewrite(fileout);
        for i := 0 to length(arr) - 1 do
            writeln(fileout, arr[i].cluster_id);
        close(filein);
        close(fileout);
    end;
    readln();
end.
