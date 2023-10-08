<table class="table">
<thead class="table-dark">
    <tr>
        <th>Riadok</th>
        <th>Názov položky</th>
        <th>Číslo dokumentu</th>
        <th>Množstvo</th>
        <th>Dátum prijatia</th>
        <th>Kupná cena</th>
        <th>Predajná cena</th>
    </tr>
</thead>
<tbody>
@foreach($goods as $value)
    <tr>
        <td>{{$loop->iteration}}</td>
        <td>{{$value->name}}</td>
        <td>{{$value->document_num}}</td>
        <td>{{$value->quantity}}</td>
        <td>{{$value->date}}</td>
        <td>{{$value->purchase}}</td>
        <td>{{$value->sale}}</td>
    </tr>
@endforeach
</tbody>
</table>
