<table class="table">
<thead class="table-dark">
    <tr>
        <th>Riadok</th>
        <th>Názov položky</th>
        <th>Číslo dokumentu</th>
        <th>Dĺžka</th>
        <th>Šírka</th>
        <th>Množstvo</th>
        <th>Dátum prijatia</th>
        <th>Kupná cena</th>
    </tr>
</thead>
<tbody>
@foreach($materials as $value)
    <tr>
        <td>{{$loop->iteration}}</td>
        <td>{{$value->name}}</td>
        <td>{{$value->document_num}}</td>
        <td>{{$value->length}}</td>
        <td>{{$value->width}}</td>
        <td>{{$value->quantity}}</td>
        <td>{{$value->date}}</td>
        <td>{{$value->purchase}}</td>
    </tr>
@endforeach
</tbody>
</table>
